module Jekyll

  class PeopleIndex < Jekyll::Prep

    def prepare(data)
      data.sort_by { |person| person.age }
    end
  end
end
