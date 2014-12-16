module MessagesRepo
	class Message
		def self.send_message user_id, msg
			sql = %Q[INSERT INTO messages (message, user_id) VALUES ($1, $2)]
			db.exec(sql, [msg, user_id])
		end
	end
end
