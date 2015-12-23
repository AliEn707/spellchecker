module ApplicationHelper
	def available_languages
		SpellcheckController::LANGUAGE_BINDINGS.keys
	end
end
