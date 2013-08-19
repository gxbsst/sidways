desc "Install gems that this app depends on. May need be run with sudo."
task :install_dependencies do
 dependencies = {
   "sinatra" => "1.3.2",
   "dm-core" => "1.2.0",
   "dm-timestamps" => "1.2.0",
   "do_sqlite3" => "0.10.8",
   "dm-sqlite-adapter" => "1.2.0"
 }
 dependencies.each do |gem_name, version|
  puts "#{gem_name} #{version}"
  system "gem install #{gem_name} --version #{version}"
 end
end
