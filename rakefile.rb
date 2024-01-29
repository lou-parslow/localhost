# this project may be viewed here: https://lou-parslow.github.io/localhost/
NAME = "localhost"
VERSION = "0.0.0"
require "raykit"

task :setup do
  run "dotnet new fluentblazorwasm -o src/#{NAME} -n #{NAME}" unless Dir.exist? "src/#{NAME}"
end

task :build do
  try "rufo ."
  run "dotnet publish src/#{NAME}/#{NAME}.csproj -c Release -o artifacts/#{NAME}.#{VERSION}"
  # GitHub Pages is configured to publish docs folder in the main branch
  FileUtils.cp_r "artifacts/#{NAME}.#{VERSION}/wwwroot/.", "docs"
  File.open("docs/.nojekyll", "w") { }
  Raykit::Text::replace_in_file("docs/index.html", '<base href="/" />', '<base href="/localhost/" />')
end

task :default => [:build, :integrate, :push] do
end
