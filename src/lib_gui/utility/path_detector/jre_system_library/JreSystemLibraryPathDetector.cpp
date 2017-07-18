#include "utility/path_detector/jre_system_library/JreSystemLibraryPathDetector.h"

#include "utility/path_detector/java_runtime/JavaPathDetector.h"

#include "settings/ApplicationSettings.h"
#include "utility/file/FilePath.h"
#include "utility/file/FileSystem.h"

JreSystemLibraryPathDetector::JreSystemLibraryPathDetector(std::shared_ptr<JavaPathDetector> javaPathDetector)
	: PathDetector("JRE System Library")
	, m_javaPathDetector(javaPathDetector)
{
}

JreSystemLibraryPathDetector::~JreSystemLibraryPathDetector()
{
}

std::vector<FilePath> JreSystemLibraryPathDetector::getPaths() const
{
	std::vector<FilePath> paths;
	for (const FilePath& jrePath: m_javaPathDetector->getPaths())
	{
		const FilePath javaRoot = jrePath.parentDirectory().parentDirectory().parentDirectory();
		for (const FilePath& jarPath : FileSystem::getFilePathsFromDirectory(javaRoot.concat(FilePath("lib")), {".jar"}))
		{
			paths.push_back(jarPath);
		}
		if (!paths.empty())
		{
			break;
		}
	}
	return paths;
}