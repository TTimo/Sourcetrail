# Generates the lincens.h file
# For adding a new 3rd Party License add the License File to the 3rd Party License Folder
# and a new AddLicense Line in below

set(LICENSES "")
set(LICENSE_ARRAY "")
set(LICENSEFOLDER "setup/3rdPartyLicenses")

function(ReadLicense licenseFile licenseVariable)
    file(READ ${licenseFile} tempVariable)
    STRING(REGEX REPLACE "\"" "\\\\\"" tempVariable "${tempVariable}")
    STRING(REGEX REPLACE "\n" "\\\\n\"\n\t\"" tempVariable "${tempVariable}")
    set(var "\n\nstatic const char *${licenseVariable}=\n\t\"")
    set(LICENSES "${LICENSES}${var}${tempVariable}\"\;" PARENT_SCOPE)
endfunction(ReadLicense)

function(AddLicense licenseName licenseURL licenseFile isNotInTrial)
        ReadLicense(${licenseFile} ${licenseName}_license)
        set(LICENSES ${LICENSES} PARENT_SCOPE)
        set(LICENSE_ARRAY "${LICENSE_ARRAY}\n\tThirdPartyLicense(\"${licenseName}\", \"${licenseURL}\", ${licenseName}_license, ${isNotInTrial})," PARENT_SCOPE)
endfunction(AddLicense)

AddLicense("Qt" "http://qt.io" "${LICENSEFOLDER}/qt_LICENSE.TXT" false)
AddLicense("Clang" "http://clang.llvm.org/" "${LICENSEFOLDER}/clang_LICENSE.TXT" true)
AddLicense("Boost" "http://www.boost.org" "${LICENSEFOLDER}/boost_LICENSE.TXT" false)
AddLicense("TinyXMl" "http://www.grinninglizard.com/tinyxml2/" "${LICENSEFOLDER}/tinyxml_LICENSE.TXT" false)
AddLicense("CppSQLite" "http://www.codeproject.com/Articles/6343/CppSQLite-C-Wrapper-for-SQLite" "${LICENSEFOLDER}/CppSQLite_LICENSE.TXT" false)
AddLicense("Botan" "http://botan.randombit.net/" "${LICENSEFOLDER}/botan_LICENSE.TXT" true)
AddLicense("Guava" "https://github.com/google/guava" "${LICENSEFOLDER}/guava_LICENSE.TXT" true)
AddLicense("Javaparser" "http://javaparser.org/" "${LICENSEFOLDER}/javaparser_LICENSE.TXT" true)
AddLicense("Javaslang" "http://www.javaslang.io/" "${LICENSEFOLDER}/javaslang_LICENSE.TXT" true)
AddLicense("Javassist" "http://www.javassist.org/" "${LICENSEFOLDER}/javassist_LICENSE.TXT" true)
AddLicense("JavaSymbolSolver" "https://github.com/ftomassetti/java-symbol-solver" "${LICENSEFOLDER}/JavaSymbolSolver_LICENSE.TXT" true)

set(LICENSE_ARRAY "${LICENSE_ARRAY}\n")

configure_file(
    ${CMAKE_SOURCE_DIR}/cmake/licenses.h.in
    ${CMAKE_SOURCE_DIR}/build/src/lib_gui/licenses.h
)
