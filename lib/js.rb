module Js

  def self.call(env)
    [200, {"Content-Type" => 'text/javascript'}, [App.new.compile]]
  end

  class App
    attr_accessor :root_path

    def initialize(*args)
      self.root_path = "app/javascripts"
    end

    def self.bundle
      new.write
    end

    def compile
      components.map { |c| "#{c.header}\n\n#{c.code}" }.join("\n\n")
    end

    def write
      File.open(Rails.root + 'public/javascripts/app.js', "w") do |f|
        f.write compile
      end
    end

    private

    def components
      _components.map do |path|
        Component.new(path, self)
      end
    end

    def _components
      ["models", "controllers"]
    end

  end

  class Component
    attr_reader :path, :app, :code

    def initialize(path, app)
      @path = path
      @app = app
      @code = render_js
    end

    def header
      "//* #{header_text} */"
    end

    def header_text
      "#{path.titleize} #{"-" * (40 - path.size)}"
    end

    def render_js
      Dir.glob("#{app.root_path}/#{path}/*.js").map do |file|
        File.read(file)
      end.join("\n\n").html_safe
    end

  end

end

