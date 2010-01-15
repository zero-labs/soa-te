namespace :local do
  desc "Puts application configuration into the environment.rb file"
  task(:app_config) do
    begin
      File.open(File.join(RAILS_ROOT, 'config', 'environment.rb'), "a") do |env|
        File.open(File.join(RAILS_ROOT, 'config', 'application.rb'), "r") do |app|
          while (line = app.gets)
            env << line
          end
        end
      end
    end
  end
end
