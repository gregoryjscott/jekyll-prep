module Jekyll
  class DbIndex < Jekyll::Prep
    def prepare(data)
      data.sort_by { |db| db.projects.count }.reverse
    end
  end
end
