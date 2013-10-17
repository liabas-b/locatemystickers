class AddUsersCompteurTriggers < ActiveRecord::Migration
  def up
  	execute "CREATE TRIGGER [TStickerUpdate]
						AFTER UPDATE ON [stickers] 
						FOR EACH ROW 
						BEGIN 
						
						update users set compteur=compteur+1 where users.id=new.user_id;

						INSERT INTO 'histories' ('created_at', 'location_id',
						'operation', 'sticker_id', 'subject', 'updated_at',
						'user_id') VALUES (CURRENT_TIMESTAMP, 0, 'updated', new.id,
						'sticker', CURRENT_TIMESTAMP, new.user_id);

						END"
  	execute "CREATE TRIGGER [TStickerInsert]
						AFTER INSERT ON [stickers]
						FOR EACH ROW
						BEGIN

						update users set compteur=compteur+1 where users.id=new.user_id;

						INSERT INTO 'histories' ('created_at', 'location_id',
						'operation', 'sticker_id', 'subject', 'updated_at',
						'user_id') VALUES (CURRENT_TIMESTAMP, 0, 'registered', new.id,
						'sticker', CURRENT_TIMESTAMP, new.user_id);

						END"
  	execute "CREATE TRIGGER [TLocationUpdate] 
						AFTER UPDATE ON [locations] 
						FOR EACH ROW 
						BEGIN 

						update users set compteur=compteur+1
            where users.id IN (select stickers.user_id FROM stickers WHERE stickers.id=new.sticker_id);

						INSERT INTO 'histories' ('created_at', 'location_id',
						'operation', 'sticker_id', 'subject', 'updated_at',
						'user_id') VALUES (CURRENT_TIMESTAMP, new.id, 'updated', new.sticker_id,
						'location', CURRENT_TIMESTAMP, 0);

						END"
  	execute "CREATE TRIGGER [TLocationInsert]
						AFTER INSERT ON [locations] 
						FOR EACH ROW 
						BEGIN 

						update users set compteur=compteur+1
            where users.id IN (select stickers.user_id FROM stickers WHERE stickers.id=new.sticker_id);

						INSERT INTO 'histories' ('created_at', 'location_id',
						'operation', 'sticker_id', 'subject', 'updated_at',
						'user_id') VALUES (CURRENT_TIMESTAMP, new.id, 'created', new.sticker_id,
						'location', CURRENT_TIMESTAMP, 0);

						END"
  	execute "CREATE TRIGGER [TMessageInsert]
						AFTER INSERT ON [messages] 
						FOR EACH ROW 
						BEGIN 

						INSERT INTO 'histories' ('created_at', 'location_id',
						'operation', 'sticker_id', 'subject', 'updated_at',
						'user_id', 'message_id', 'notify') VALUES (CURRENT_TIMESTAMP, 0, 'received', 0,
						'message', CURRENT_TIMESTAMP, new.user_id, new.id, 1);

						END"
  end

  def down
  	execute "DELETE TRIGGER [TStickerUpdate]"
  	execute "DELETE TRIGGER [TLocationUpdate]"
  	execute "DELETE TRIGGER [TStickerInsert]"
  	execute "DELETE TRIGGER [TLocationInsert]"
  	execute "DELETE TRIGGER [TMessageInsert]"
  end
end
