DOCKER_COMPOSE_FILE_REGEX = /docker-compose(.*)\.yml$/

def pull_docker_compose_file(name)
  `docker-compose -f #{name} pull`
end

file_names = Dir.entries(Dir.pwd)
docker_compose_file_names = file_names.select do |name|
  DOCKER_COMPOSE_FILE_REGEX.match?(name)
end

if docker_compose_file_names.length === 1
  pull_docker_compose_file(docker_compose_file_names.first)
else
  puts "Which file?"
  puts "-----------"
  docker_compose_file_names.each_with_index do |name, idx|
    puts "#{idx}) #{name}"
  end
  puts "-----------"

  begin
    selected_index = Integer(gets.chomp)
    if selected_index > docker_compose_file_names.length - 1
      raise "I don't have that file."
    end

    pull_docker_compose_file(docker_compose_file_names[selected_index])
  rescue ArgumentError
    raise "Invalid input"
  end
end
