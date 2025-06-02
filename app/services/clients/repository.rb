module Clients
  class Repository < Micro::Case

    def call!
      ## cachear clients
      Client.all
    end
  end
end
