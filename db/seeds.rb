users = [
    %W"名字 氏名 ふりがな test@example.com 字"
]


for user in users do
User.create!(
    last_name: user[0],
    first_name: user[1],
    furigana: user[2],
    email: user[3],
    nickname: user[4],
    joined: 2016,
    activated: true,
    password_digest: BCrypt::Password.create("test"),
    admin: true
)
end
