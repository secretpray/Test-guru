class GistQuestionService

  STATUS_SUCCESS = [200, 201]

  def initialize(question, client = Octokit::Client.new(access_token: ENV['ACCESS_TOKEN']))
    @question = question
    @test = @question.test
    @test = question.test
    @client = client
  end

  def call
    @client.create_gist(gist_params)
  end

  def success?
    STATUS_SUCCESS.include? @client.last_response.status
  end


  private

  def gist_params
    {
        "description": I18n.t('.description', title: @test.title),
        "files": {
            "test-guru-question.txt": {
                "content": gist_content
            }
        }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end
