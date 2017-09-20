@httpbin
Feature:
  Httpbin.org exposes various resources for HTTP request testing
  As Httpbin client I want to verify that all API resources are working as they should

  Scenario: Setting headers in GET request
    Given I set User-Agent header to apickli
    When I GET /get
    Then response body path $.headers.User-Agent should be apickli

  Scenario: checking values of headers passed as datatable in get request
    Given I set headers to
      | name          | value            |
      | Accept        | application/json |
      | User-Agent    | apickli          |
    When I GET /get
    Then response body path $.headers.Accept should be application/json
    And response body path $.headers.User-Agent should be apickli

  Scenario: combine headers passed as table and Given syntax
    Given I set Custom-Header header to abcd
    And I set headers to
      | name       | value            |
      | User-Agent | apickli          |
      | Accept     | application/json |
    When I GET /get
    Then response body path $.headers.Accept should be application/json
    And response body path $.headers.User-Agent should be apickli
    And response body path $.headers.Custom-Header should be abcd

  Scenario: Same header field with multiple values
    Given I set Custom-Header header to A
    And I set Custom-Header header to B
    And I set headers to
      | name          | value |
      | Custom-Header | C     |
      | Custom-Header | D     |
    When I GET /get
    Then response body path $.headers.Custom-Header should be A,B,C,D

  Scenario: Setting cookie in GET request
    Given I set cookie to test=value; HttpOnly
    When I GET /get
    Then response body path $.headers.Cookie should be test=value

  Scenario: Setting body payload in POST request
    Given I set body to {"key":"hello-world"}
    When I POST to /post
    Then response body should contain hello-world

  Scenario: Setting body payload in PUT request
    Given I set body to {"key":"hello-world"}
    When I PUT /put
    Then response body should contain hello-world

  Scenario: Setting body payload in DELETE request
    Given I set body to {"key":"hello-world"}
    When I DELETE /delete
    Then response body should contain hello-world
