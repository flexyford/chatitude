module MessagesRepo
	class Message
		def self.save db, user_data
			if user_data['id']
				result = db.exec("UPDATE message SET message = $2 WHERE userId = $1", [user_data['id'], user_data['message']])
			else
				sql = %Q[INSERT INTO messages (userId, message) VALUES ($1, $2)]
				db.exec(sql, [user_data['id'], user_id['message']])
		end
	end
end
