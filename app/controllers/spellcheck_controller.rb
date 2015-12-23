class SpellcheckController < ApplicationController
	skip_before_filter :verify_authenticity_token
	
	LANGUAGE_BINDINGS={
		'ar'=>'ar',
		'az'	=>'az',
		'be'	=>'be_BY',
		'bg'	=>'bg_BG',
		'ca'	=>'ca',
		'cs'	=>'cs_CZ',
		'da'	=>'da_DK',
		'de'	=>'de_DE_frami',
		'el'	=>'el_GR',
		'en'	=>'en_US',
		'es'	=>'es_ES',
		'et'	=>'et_EE',
		'fr'	=>'fr',
		'gl'	=>'gl_ES',
		'he'	=>'he_IL',
		'hr'	=>'hr_HR',
		'hy'	=>'hy_AM',
		'it'	=>'it_IT',
		'lt'	=>'lt_LT',
		'nl'	=>'nl_NL',
		'pl'	=>'pl_PL',
		'pt'	=>'pt_BR',
		'ro'	=>'ro_RO',
		'ru'	=>'ru_RU',
		'sl'	=>'si_SI',
		'sk'	=>'sk_SK',
		'sr'	=>'sr',
		'sv'	=>'sv_SE',
		'uk'	=>'uk_UA',
		'vi'	=>'vi_VN'
	}
	
	WORDS_LIMIT=5000
	
	def check
		host=request.headers['origin'] || request.headers['referer'][/[^\/]*\:\/\/[^\/]*/]
		domain=Domain.where(name: host).first#use host for statistics and users
		if (LANGUAGE_BINDINGS[params["lang"]] && domain && domain.words<WORDS_LIMIT) then
			domain.requests+=1
			if (params['text']) then
				obj={outcome: "success"}
				data=[]
				FFI::Hunspell.dict(LANGUAGE_BINDINGS[params["lang"]]) do |dict|
					params['text'].each do |a|
						words=[]
						a.split.each do |word|
							domain.words+=1
							if (domain.words<WORDS_LIMIT)
								words<< word if (!dict.check?(word))
							end
						end
						data<<words
					end
				end
				obj[:data]=data
			elsif (params['word']) then
				FFI::Hunspell.dict(LANGUAGE_BINDINGS[params["lang"]]) do |dict|
					domain.words+=1
					obj=dict.suggest(params['word'])
				end
			end
			domain.save
		else
			obj={outcome: "failure"}
			obj[:error]="can't found #{host}" if (!domain)
			obj[:error]="limit for #{host} reached" if (domain && domain.words>WORDS_LIMIT)
		end
#		headers['Access-Control-Allow-Origin'] = '*'
#		headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
#		headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
#		headers['Access-Control-Max-Age'] = "1728000"
		render json: obj
	end
end
