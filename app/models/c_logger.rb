class CLogger
	include ApplicationHelper
	
	def self.debug(message)
		write_to_debug('debug', message)
	end

	def self.info(message)
		write_to_logs('info', message)
	end
	
	def self.warning(message)
		write_to_logs('warning', message)
	end
	
	def self.todo(message)
		write_to_logs('todo', message)
	end

	def self.error(message)
		write_to_logs('error', message)
	end

	private

		def self.open_file
			@date = Time.new
			@file = File.open('log/' + @date.year.to_s + @date.month.to_s + @date.day.to_s + 'app_logs.log', 'a')
		end

		def self.open_debug_file
			@date = Time.new
			@file = File.open('log/' + @date.year.to_s + @date.month.to_s + @date.day.to_s + 'debug_logs.log', 'a')
		end

		def self.write_to_logs(level, message)
			if Rails.configuration.debug_active == true
				open_file
				@file.write('$ [' + level + '] - ' + @date.to_s + ' - ' + message + "\n")
				@file.close
			end
		end

		def self.write_to_debug(level, message)
			if Rails.configuration.debug_active == true
				open_debug_file
				@file.write('$ ' + @date.to_s + ' - ' + message + "\n")
				puts '$ ' + @date.to_s + ' - ' + message + "\n"
				@file.close
			end
		end
end
