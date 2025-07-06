cmake_minimum_required(VERSION 3.16)

project(SAPER VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Core)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appSAPER
    src/main.cpp
)

qt_add_qml_module(appSAPER
    URI SAPER
    VERSION 1.0
    QML_FILES
        resources/Main.qml
        resources/Minefield.qml
        resources/Options.qml
        resources/Cell.qml
        resources/GameResultDialog.qml
    SOURCES
        src/sapermodel.h
        src/sapermodel.cpp
        src/gamesettingsmanager.h
        src/gamesettingsmanager.cpp
        src/sapercontroller.h
        src/sapercontroller.cpp
        src/gametimer.h
        src/gametimer.cpp
    RESOURCES
        resources/resources.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appSAPER PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSAPER
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSAPER
    PRIVATE Qt6::Quick
)
target_link_libraries(appSAPER PRIVATE Qt6::Core)
target_link_libraries(appSAPER PRIVATE Qt6::Core)
target_include_directories(appSAPER PRIVATE src)

include(GNUInstallDirs)
install(TARGETS appSAPER
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
