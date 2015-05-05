require('sinatra')
require('sinatra/reloader')
require('./lib/to_do')
require('./lib/list')
also_reload('lib/**/*.rb')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'task_master_test'})

get('/') do
  @lists = List.all()
  erb(:index)
end

get('/list') do
  erb(:list_form)
end

post('/additem') do
  name = params.fetch("name")
  @list = List.new({:name => name, :id => nil})
  @list.save()
  erb(:add_item)
end

post('/success') do
  description = params.fetch("description")
  due_date = params.fetch("due_date")
  list_id = params.fetch("list_id").to_i()
  @task = Task.new({:description => description, :list_id => list_id, :due_date => due_date})
  @task.save()
  erb(:success)
end
