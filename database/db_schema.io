Table users {
  id uuid [pk]
  name varchar [not null]
  created_at timestamp [default: `now()`]

  Note: 'Пользователи социальной сети'
}

Table subscriptions {
  id uuid [pk]
  user_id uuid [not null, ref: > users.id]
  subscriber_id uuid [not null, ref: > users.id]
  created_at timestamp [default: `now()`]

  indexes {
    (user_id, subscriber_id) [unique]
    subscriber_id
    user_id
  }

  Note: 'Подписки пользователей друг на друга'
}

Table places {
  id uuid [pk]
  name varchar [not null]
  description text
  rating decimal(3,2)
  post_count integer [default: 0]
  created_at timestamp [default: `now()`]

  Note: 'Места, к которым привязываются посты'
}

Table posts {
  id uuid [pk]
  description varchar(500) [not null]
  user_id uuid [not null, ref: > users.id]
  place_id uuid [not null, ref: > places.id]
  created_at timestamp [default: `now()`]
  comment_count integer [default: 0]
  reaction_count integer [default: 0]

  indexes {
    (user_id, created_at)
    (place_id, created_at)
  }

  Note: 'Посты пользователей о местах'
}

Table reactions {
  id uuid [pk]
  post_id uuid [not null, ref: > posts.id]
  user_id uuid [not null, ref: > users.id]
  emoji varchar [not null]
  created_at timestamp [default: `now()`]

  indexes {
    (post_id, user_id) [unique]
    post_id
    user_id
  }

  Note: 'Реакции пользователей на посты'
}

Table comments {
  id uuid [pk]
  post_id uuid [not null, ref: > posts.id]
  user_id uuid [not null, ref: > users.id]
  message varchar(200) [not null]
  attachment_id uuid [ref: > files.id]
  created_at timestamp [default: `now()`]

  indexes {
    post_id
  }

  Note: 'Комментарии пользователей к постам'
}

Table files {
  id uuid [pk]
  url varchar [not null]
  upload_date timestamp [default: `now()`]
  file_size integer
  mime_type varchar

  Note: 'Загруженные файлы (изображения)'
}

Table post_attachments {
  id uuid [pk]
  post_id uuid [not null, ref: > posts.id]
  file_id uuid [not null, ref: > files.id]
  position integer

  indexes {
    (post_id, file_id) [unique]
    post_id
  }

  Note: 'Прикрепленные файлы к постам (максимум 3 на пост)'
}
