module Chatitude
	class MessagesRepo

    def self.all db
      result = db.exec <<-SQL
        SELECT u.username, m.time, m.message
        FROM users u
        JOIN messages m
        ON m."userId" = u.id
      SQL
      result.entries
    end

		def self.save db, message_data
			if message_data['id']
				result = db.exec("UPDATE message SET message = $2 WHERE userId = $1", [message_data['id'], message_data['message']])
			elsif message_data['message'] == ""
				raise ("Message text cannot be blank")
			else
				sql = %Q[INSERT INTO messages ("userId", message) VALUES ($1, $2)]
				db.exec(sql, [message_data['userId'], message_data['message']])
			end
		end
	end
end