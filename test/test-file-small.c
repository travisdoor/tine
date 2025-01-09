// =================================================================================================
// bl
//
// File:   conf.c
// Author: Martin Dorazil
// Date:   12/19/21
//
// Copyright 2021 Martin Dorazil
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
// =================================================================================================

#include "builder.h"
#include "conf.h"
#include "stb_ds.h"
#include <yaml.h>

// =================================================================================================
// Generic configuration loading
// =================================================================================================
struct entry {
	hash_t      key;
	const char *value;
};

struct config {
	struct entry        *data;
	struct string_cache *cache;
};

struct config *confload(const char *filepath) {
	FILE *input = fopen(filepath, "rb");
	if (!input) {
		return NULL;
	}

	yaml_parser_t parser;
	yaml_parser_initialize(&parser);
	yaml_parser_set_input_file(&parser, input);

	struct config *conf = bmalloc(sizeof(struct config));
	conf->data          = NULL;
	conf->cache         = NULL;

	// insert special entry for filename
	struct entry entry;
	entry.key   = strhash(make_str_from_c(CONF_FILEPATH));
	entry.value = scdup(&conf->cache, filepath, strlen(filepath));
	hmputs(conf->data, entry);

	enum state { STATE_KEY,
		         STATE_VALUE } state = STATE_KEY;

	char blockpath[256] = "";

	yaml_token_t token;
	str_buf_t    key  = get_tmp_str();
	str_buf_t    path = get_tmp_str();

	bool done = false;
	while (!done) {
		if (!yaml_parser_scan(&parser, &token)) goto LOAD_ERROR;

		switch (token.type) {
		case YAML_STREAM_START_TOKEN:
			break;
		case YAML_KEY_TOKEN:
			state = STATE_KEY;
			break;
		case YAML_VALUE_TOKEN:
			state = STATE_VALUE;
			break;
		case YAML_BLOCK_MAPPING_START_TOKEN:
			if (key.len) {
				snprintf(blockpath, static_arrlenu(blockpath), "/%.*s", key.len, key.ptr);
			}
			break;
		case YAML_BLOCK_END_TOKEN:
			for (usize i = strlen(blockpath); i-- > 0;) {
				if (blockpath[i] == '/') {
					blockpath[i] = '\0';
					break;
				}
			}
			break;
		case YAML_SCALAR_TOKEN: {
			const char *value = (const char *)token.data.scalar.value;
			if (state == STATE_KEY) {
				str_buf_clr(&key);
				str_buf_append(&key, make_str_from_c(value));
			} else {
				str_buf_clr(&path);
				str_buf_append_fmt(&path, "{s}/{str}", blockpath, key);
				entry.key   = strhash(path);
				entry.value = scdup(&conf->cache, value, token.data.scalar.length);
				hmputs(conf->data, entry);
			}
			break;
		}
		case YAML_STREAM_END_TOKEN:
			done = true;
			break;
		default:
			bwarn("%s:%d:%d: YAML Unknown token type!",
			      filepath,
			      token.start_mark.line,
			      token.start_mark.column);
			break;
		}
		yaml_token_delete(&token);
	}
	yaml_parser_delete(&parser);
	fclose(input);
	put_tmp_str(key);
	put_tmp_str(path);
	return conf;

LOAD_ERROR:
	yaml_parser_delete(&parser);
	fclose(input);
	confdelete(conf);
	put_tmp_str(key);
	put_tmp_str(path);
	return NULL;
}

void     confdelete(struct config *conf) {
	if (!conf) return;
	hmfree(conf->data);
	scfree(&conf->cache);
	bfree(conf);
}

const char *confreads(struct config *conf, const char *path, const char *default_value) {
	bassert(conf);
	const hash_t hash  = strhash(make_str_from_c(path));
	const s64    index = hmgeti(conf->data, hash);
	if (index == -1) {
		if (default_value) return default_value;
		babort("Unknown configuration entry '%s'!", path);
	}
	return conf->data[index].value;
}

foo[0] = VK_ATTACHMENT_UNUSED              (~0U)
foo[1] = VK_FALSE                          0U
foo[2] = VK_LOD_CLAMP_NONE                 1000.0F
foo[3] = VK_QUEUE_FAMILY_IGNORED           (~0U)
foo[4] = VK_REMAINING_ARRAY_LAYERS         (~0U)
foo[5] = VK_REMAINING_MIP_LEVELS           (~0U)
foo[6] = VK_SUBPASS_EXTERNAL               (~0U)
foo[7] = VK_TRUE                           1U
foo[8] = VK_WHOLE_SIZE                     (~0ULL)
foo[9] = VK_MAX_MEMORY_TYPES               32U
foo[10] = VK_MAX_PHYSICAL_DEVICE_NAME_SIZE  256U
foo[11] = VK_UUID_SIZE                      16U
foo[12] = VK_MAX_EXTENSION_NAME_SIZE        256U
foo[13] = VK_MAX_DESCRIPTION_SIZE           256U
foo[14] = VK_MAX_MEMORY_HEAPS               16U

typedef enum VkResult {
	VK_SUCCESS = 0,
	VK_NOT_READY = 1,
	VK_TIMEOUT = 2,
	VK_EVENT_SET = 3,
	VK_EVENT_RESET = 4,
	VK_INCOMPLETE = 5,
	VK_ERROR_OUT_OF_HOST_MEMORY = -1,
	VK_ERROR_OUT_OF_DEVICE_MEMORY = -2,
	VK_ERROR_INITIALIZATION_FAILED = -3,
	VK_ERROR_DEVICE_LOST = -4,
	VK_ERROR_MEMORY_MAP_FAILED = -5,
	VK_ERROR_LAYER_NOT_PRESENT = -6,
	VK_ERROR_EXTENSION_NOT_PRESENT = -7,
	VK_ERROR_FEATURE_NOT_PRESENT = -8,
	VK_ERROR_INCOMPATIBLE_DRIVER = -9,
	VK_ERROR_TOO_MANY_OBJECTS = -10,
	VK_ERROR_FORMAT_NOT_SUPPORTED = -11,
	VK_ERROR_FRAGMENTED_POOL = -12,
	VK_ERROR_UNKNOWN = -13,
	VK_ERROR_OUT_OF_POOL_MEMORY = -1000069000,
	VK_ERROR_INVALID_EXTERNAL_HANDLE = -1000072003,
	VK_ERROR_FRAGMENTATION = -1000161000,
	VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS = -1000257000,
	VK_PIPELINE_COMPILE_REQUIRED = 1000297000,
	VK_ERROR_SURFACE_LOST_KHR = -1000000000,
	VK_ERROR_NATIVE_WINDOW_IN_USE_KHR = -1000000001,
	VK_SUBOPTIMAL_KHR = 1000001003,
	VK_ERROR_OUT_OF_DATE_KHR = -1000001004,
	VK_ERROR_INCOMPATIBLE_DISPLAY_KHR = -1000003001,
	VK_ERROR_VALIDATION_FAILED_EXT = -1000011001,
	VK_ERROR_INVALID_SHADER_NV = -1000012000,
	VK_ERROR_IMAGE_USAGE_NOT_SUPPORTED_KHR = -1000023000,
	VK_ERROR_VIDEO_PICTURE_LAYOUT_NOT_SUPPORTED_KHR = -1000023001,
	VK_ERROR_VIDEO_PROFILE_OPERATION_NOT_SUPPORTED_KHR = -1000023002,
	VK_ERROR_VIDEO_PROFILE_FORMAT_NOT_SUPPORTED_KHR = -1000023003,
	VK_ERROR_VIDEO_PROFILE_CODEC_NOT_SUPPORTED_KHR = -1000023004,
	VK_ERROR_VIDEO_STD_VERSION_NOT_SUPPORTED_KHR = -1000023005,
	VK_ERROR_INVALID_DRM_FORMAT_MODIFIER_PLANE_LAYOUT_EXT = -1000158000,
	VK_ERROR_NOT_PERMITTED_KHR = -1000174001,
	VK_ERROR_FULL_SCREEN_EXCLUSIVE_MODE_LOST_EXT = -1000255000,
	VK_THREAD_IDLE_KHR = 1000268000,
	VK_THREAD_DONE_KHR = 1000268001,
	VK_OPERATION_DEFERRED_KHR = 1000268002,
	VK_OPERATION_NOT_DEFERRED_KHR = 1000268003,
	VK_ERROR_INVALID_VIDEO_STD_PARAMETERS_KHR = -1000299000,
	VK_ERROR_COMPRESSION_EXHAUSTED_EXT = -1000338000,
	VK_INCOMPATIBLE_SHADER_BINARY_EXT = 1000482000,
	VK_PIPELINE_BINARY_MISSING_KHR = 1000483000,
	VK_ERROR_NOT_ENOUGH_SPACE_KHR = -1000483000,
	VK_ERROR_OUT_OF_POOL_MEMORY_KHR = VK_ERROR_OUT_OF_POOL_MEMORY,
	VK_ERROR_INVALID_EXTERNAL_HANDLE_KHR = VK_ERROR_INVALID_EXTERNAL_HANDLE,
	VK_ERROR_FRAGMENTATION_EXT = VK_ERROR_FRAGMENTATION,
	VK_ERROR_NOT_PERMITTED_EXT = VK_ERROR_NOT_PERMITTED_KHR,
	VK_ERROR_INVALID_DEVICE_ADDRESS_EXT = VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS,
	VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS_KHR = VK_ERROR_INVALID_OPAQUE_CAPTURE_ADDRESS,
	VK_PIPELINE_COMPILE_REQUIRED_EXT = VK_PIPELINE_COMPILE_REQUIRED,
	VK_ERROR_PIPELINE_COMPILE_REQUIRED_EXT = VK_PIPELINE_COMPILE_REQUIRED,
	// VK_ERROR_INCOMPATIBLE_SHADER_BINARY_EXT is a deprecated alias
	VK_ERROR_INCOMPATIBLE_SHADER_BINARY_EXT = VK_INCOMPATIBLE_SHADER_BINARY_EXT,
	VK_RESULT_MAX_ENUM = 0x7FFFFFFF
} VkResult;
