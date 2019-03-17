find_package(Git REQUIRED)

execute_process(
    COMMAND           "${GIT_EXECUTABLE}" describe --long --dirty --tags --match v[0-9]*
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    RESULT_VARIABLE   git_result
    OUTPUT_VARIABLE   git_tag
    ERROR_VARIABLE    git_error
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_STRIP_TRAILING_WHITESPACE
  )

if( NOT git_result EQUAL 0 )
    message( FATAL_ERROR "Failed to execute Git: ${git_error}" )
endif()

if( git_tag MATCHES "v([0-9]+).([0-9]+).([0-9]+)-([0-9]+)-g([0-9,a-f]+)(-dirty)?" )
    set( git_version_major           "${CMAKE_MATCH_1}" )
    set( git_version_minor           "${CMAKE_MATCH_2}" )
    set( git_version_patch           "${CMAKE_MATCH_3}" )
    set( git_commits_since_last_tag  "${CMAKE_MATCH_4}" )
    set( git_hash                    "${CMAKE_MATCH_5}" )
    set( git_wip                     "${CMAKE_MATCH_6}" )
else()
    message( FATAL_ERROR "Git tag isn't valid semantic version: [${git_tag}]" )
endif()

execute_process(
    COMMAND           "${GIT_EXECUTABLE}" rev-parse --abbrev-ref HEAD
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    RESULT_VARIABLE   git_result
    OUTPUT_VARIABLE   git_current_branch
    ERROR_VARIABLE    git_error
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_STRIP_TRAILING_WHITESPACE
  )
if( NOT git_result EQUAL 0 )
    message( FATAL_ERROR "Failed to execute Git: ${git_error}" )
endif()
