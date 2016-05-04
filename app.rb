# блог
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

# процедура инициализации
configure do
	# подключаемся, а при отсутствии создаем БД
	$db=SQLite3::Database.new "./database.db"
	# результаты запроса выводятся в виде хеша
	$db.results_as_hash = true
	# создается таблица
	$db.execute("CREATE  TABLE  IF NOT EXISTS posts (p_id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, 
													 p_name VARCHAR, 
													 p_post VARCHAR, 
													 p_date DATETIME DEFAULT (datetime('now', 'localtime')))")
end

# главная страница
get '/' do
	erb :posts
end

# добавить пост
get '/new' do
	erb :new
end

# детальная информация о посте №:id
get '/post/:id' do
	@id=params[:id]
	erb :onepost
end

# обработчик формы создания поста
post '/new' do
  @name=params[:name]
  @post=params[:post]

  # получение сообщения об ошибке. если есть, то снова вводим,
  # если нет, то пост записывается в БД и идет перенаправление на главную страницу
  @error=get_error_message({:name=>"Enter your name. ", :post=>"Enter your post"})
  if @error==""
  	$db.execute("INSERT INTO posts (p_name, p_post) VALUES (?, ?)", [@name, @post])
  	redirect to ('/')
  else
  	erb :new
  end
end

# возвращает сообщение о возможных ошибках. принмимает хеш с парой
# имя_параметра=>выводимое сообщение. если параметр пустой, формируется сообщение
def get_error_message(hh)
	err=""
	hh.each_key {|param| err+=hh[param] if params[param].strip==""}
	return err
end
