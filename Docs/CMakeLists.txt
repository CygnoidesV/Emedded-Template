project(EmeddedDoc NONE)

# Set some Doxygen flags
set(EMEDDED_DOC_DIR                       "${EMEDDED_SOURCE_DIR}/Docs")
set(EMEDDED_DOXY_PATH                     "${EMEDDED_DOC_DIR}/doxygen")
set(EMEDDED_DOXY_IMAGE_FOLDER_NAME        "image")
set(EMEDDED_DOXY_IMAGE_PATH               "${EMEDDED_DOC_DIR}/${EMEDDED_DOXY_IMAGE_FOLDER_NAME}")
set(EMEDDED_DOXY_PROJECT_NAME             "电控组文档")
set(EMEDDED_DOXY_PROJECT_NUMBER           "v1.0.0")
set(EMEDDED_DOXY_PROJECT_BRIEF            "鸿雁战队RoboMaster")
set(EMEDDED_DOXY_INPUT                    "\"${EMEDDED_SOURCE_DIR}/\" \"${EMEDDED_DOC_DIR}/\"")
set(EMEDDED_DOXY_EXAMPLE_PATH             "\"${EMEDDED_DOC_DIR}/examples\"")
set(EMEDDED_DOXY_EXCLUDE_PATTERNS " */build/* */Middlewares/* \
                                   */CMake/* */CMSIS/* */STM32F4xx_HAL_Driver/* \
                                  */doxygen-awesome-css/* */doxygen/* system_stm32f4xx.c")
set(EMEDDED_DOXY_RECURSIVE                "YES")
configure_file(
  ${EMEDDED_DOC_DIR}/doxygen/Doxyfile.in
  ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
)

# You can use usergroup to add subpage to treeview
# Example:
#     <tab type="usergroup" url="@ref group_page" title="My Group">
#       <tab type="user" url="@ref test" title="test"/>
#     </tab>

# set(EMEDDED_DOC_TREE    "<tab type=\"user\" url=\"@ref mypage\" title=\"The Title\"/> \
#                         <tab type=\"user\" url=\"@ref mypage\" title=\"The Title\"/>)"
set(EMEDDED_DOC_ENDTREE "<tab type=\"user\" url=\"@ref getting_started\" title=\"开发环境配置\"/> \
                        <tab type=\"usergroup\" url=\"@ref code_guide_style\" title=\"代码规范\"> \
                          <tab type=\"user\" url=\"@ref c_guide_style\" title=\"C语言规范-备份\"/> \
                        </tab>")
configure_file(
  ${EMEDDED_DOC_DIR}/doxygen/DoxygenLayout.xml.in
  ${CMAKE_CURRENT_BINARY_DIR}/DoxygenLayout.xml
)

add_custom_target(doc
  COMMAND doxygen ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
  COMMAND cmake -E copy_directory ${EMEDDED_DOXY_IMAGE_PATH} ${CMAKE_CURRENT_BINARY_DIR}/html/image
)

