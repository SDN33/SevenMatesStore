module ApplicationHelper
  def translated_payment_method_name(partial_name)
    case partial_name
    when 'credit_card'
      ("carte de crédit")
    when 'check'
      ('chèque de banque')
    else
      partial_name # Retourne le nom partiel tel quel si non défini pour la traduction
    end
  end
end
