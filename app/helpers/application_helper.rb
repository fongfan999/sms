module ApplicationHelper
	def title(*parts)
		unless parts.empty?
			content_for :title do
				(parts << "UIT").join(" - ")
			end
		end
	end

	def admins_only(&block)
		block.call if current_user.try(:admin?)
	end

	def format_date(date, time = true)
		time ? date.strftime("%d-%m-%Y, %H:%M") : date.strftime("%d-%m-%Y")
	end
end
