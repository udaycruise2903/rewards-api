-- name: GetUserScratchcardsByScratchId :one
SELECT * FROM user_scratchcards
WHERE sc_id = $1 LIMIT 1;

INSERT INTO user_scratchcards (user_id,status) VALUES
  ('chris1','available'),
  ('chris1','available'),
  ('john43','available');