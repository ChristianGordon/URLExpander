require "test_helper"

class UrlControllerTest < ActionDispatch::IntegrationTest
  test "no redirects" do
    get("/expand_url", params: {url: "https://example.com"})
    #checks that the return status is 200
    assert_equal 200, status
    #parses the body of the response of the request
    body = JSON.parse(response.body)
    #changes all keys in hash to symbols
    body = body.symbolize_keys
    #stores expected body response
    expected_body = {original_url: "https://example.com", num_redirects: 0, final_url: "https://example.com", response_format: "text/html; charset=UTF-8"}
    #compares two bodies
    assert_equal expected_body, body
  end

  test "many redirects" do
    get("/expand_url", params: {url: "https://tinyurl.com/978nzb9f"})
    #checks that the return status is 200
    assert_equal 200, status
    #parses the body of the response of the request
    body = JSON.parse(response.body)
    #changes all keys in hash to symbols
    body = body.symbolize_keys
    #stores expected body response
    expected_body = {original_url: "https://tinyurl.com/978nzb9f", num_redirects: 2, final_url: "https://www.youtube.com/", response_format: "text/html; charset=utf-8"}
    #compares two bodies
    assert_equal expected_body, body
  end
end
