# блог
require 'sinatra'
require 'sinatra/reloader'

# процедура инициализации
configure do

end

# главная страница
get '/' do
	erb "<h1>Hello!</h1>"
end

# добавить пост
get '/new' do
	erb :new
end

# обработчик формы создания поста
post '/new' do
  @name=params[:name]
  @post=params[:post]
  @error=get_error_message({:name=>"Enter your name. ", :post=>"Enter your post"})
  if @error==""
  	erb "<p>#{@name} add post: #{@post}</p>"
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
