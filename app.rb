#encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'

# процедура инициализации
configure do

end

# главная страница
get '/' do
	erb "<h1> Hello! </h1>"
end

# 1
get '/one' do
	erb "<h2> One </h2>"
end

# 2
get '/two' do
	erb "<h2> Two </h2>"
end

# 3
get '/three' do
	erb "<h2> Three </h2>"
end

# возвращает сообщение о возможных ошибках. принмимает хеш с парой
# имя_параметра=>выводимое сообщение. если параметр пустой, формируется сообщение
def get_error_message(hh)
	err=""
	hh.each_key {|param| err+=hh[param] if params[param].strip==""}
	return err
end
