# Copyright 2015-2022 Daniel Weiner
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if(NOT _FUSION_MAIN_PROJECT)
    return()
endif()
if(NOT WIN32)
    message(FATAL_ERROR "WIndows platform file included on a non-WIN32 system")
endif()

if(FUSION_SUPPORTS_ASAN)
    FSN_CREATE_BUILD_CONFIG(Asan ${ADDRESS_SANITIZER_COMPILER_FLAG} "")
endif()
if(FUSION_SUPPORTS_UBSAN)
    FSN_CREATE_BUILD_CONFIG(Ubsan ${UNDEFINED_SANITIZER_COMPILER_FLAG} "")
endif()

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<OR:$<CONFIG:Debug>,$<CONFIG:Asan>,$<CONFIG:RelWithDebInfo>>:Debug>")

# Set Debug specific flags
# /Z7 - produce .obj files for debugging
# /FC - use full pathnames in debugging
FSN_ADD_COMPILER_FLAGS(DEBUG CXX /Z7 /FC)
FSN_ADD_COMPILER_FLAGS(DEBUG C /Z7 /FC)

# Set global compiler flags. These will affect all configurations
# /MP - Enable multi-processor builds
# /GS - enable buffer overflow checking
# /GR- - Disable Runtime-Type-Checking (RTTI)
# /DEBUG - Generate .pdb files for debugging
# /LARGEADDRESSAWARE - mark executable for using >2GB addresses
# /UNICODE - Enable wchar_t types
FSN_ADD_COMPILER_FLAGS(CXX /MP /GR- /GS /UNICODE)
FSN_ADD_LINKER_FLAGS(/DEBUG /LARGEADDRESSAWARE)

# Global Definitions that effect every project built.
add_definitions(-D_CRT_SECURE_NO_WARNINGS=1)
add_definitions(-D_SILENCE_TR1_NAMESPACE_DEPRECATION_WARNING=1)
add_definitions(-DUNICODE -D_UNICODE)
add_definitions(-DWIN32_LEAN_AND_MEAN)
