module MessagesRepo
	class Message
		def self.save db, message_data
			if message_data['id']
				result = db.exec("UPDATE message SET message = $2 WHERE userId = $1", [message_data['id'], message_data['message']])
			elsif message_data['message'] = ""
				raise ("Message text cannot be blank")
			else
				sql = %Q[INSERT INTO messages (userId, message) VALUES ($1, $2)]
				db.exec(sql, [message_data['user_id'], message_data['message']])
		end
	end
end
