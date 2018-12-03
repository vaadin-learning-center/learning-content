from glob import glob
import javaproperties
import ntpath
import os.path
import re

TUTORIALS_ROOT="tutorials"
MANDATORY_TOPIC_PROPERTIES = []
MANDATORY_ARTICLE_PROPERTIES = ["title", "author"]
MANDATORY_SECTION_PROPERTIES = MANDATORY_ARTICLE_PROPERTIES


with open('tutorials/allowed_topics.lst') as allowedTopicsFile:
  ALLOWED_TOPICS = [line.rstrip('\n') for line in allowedTopicsFile]
with open('tutorials/allowed_tags.lst') as allowedTopicsFile:
  ALLOWED_TAGS = [line.rstrip('\n') for line in allowedTopicsFile]

# global error log to be returned as CI results
errors = []

# Traverses /tutorials to validate
# - mandatory files and properties
# - valid topics and tags
#
# TODO:
# - front matter support
# - section names should start with a order prefix XX__
def main():
	print("""
	Testing tutorials...
	""")

	for topic in glob(TUTORIALS_ROOT + "/*/"):
		print("Checking topic " + topic + "...")
		# check topic name
		topicName = path_leaf(topic)
		if not topicName in ALLOWED_TOPICS:
			log_error("Error: Topic name is not allowed: '" + topicName + "' - Check tutorials/allowed_topics.lst and extend it if needed.")

		# check topic properties
		if not os.path.isfile(topic + "/topic.properties"):
			log_error("Error: Missing topic.properties file in " + topic)

		# check articles
		for article in glob(topic + "/*/"):
			check_article_or_section(article, MANDATORY_ARTICLE_PROPERTIES)
			# check sections
			for section in glob(article + "/*__*/"):
				check_article_or_section(section, MANDATORY_SECTION_PROPERTIES)

# Checks article or section properties
def check_article_or_section(folder, mandatoryProps):
	print("Checking " + folder + "...")
	props = get_properties(folder)
	for prop in mandatoryProps:
		try:
			if not props[prop]:
				log_error("Error: Missing mandatory property '" + prop + "' in " + folder)
		except:
			log_error("Error: Missing mandatory property '" + prop + "' in " + folder)

	try:
		tags = [x.strip() for x in props["tags"].split(',')]
		for tag in tags:
			if tag not in ALLOWED_TAGS:
				log_error("Error: Invalid tag '" + tag + "' in '" + folder + "' found - Check tutorials/allowed_tags.lst and extend it if needed.")
	except:
		# ignore as tags are not mandatory
		print

# Prints and records given error
def log_error(msg):
	errors.append(msg)
	print(msg)

# Returns all article or section properties found in the given folder
def get_properties(folder):
	# check for full article
	if os.path.isfile(folder + "/article.properties"):
		with open(folder + "/article.properties", "r", encoding="utf-8") as fp:
			return javaproperties.load(fp)
	# check for full section
	elif os.path.isfile(folder + "/section.properties"):
		with open(folder + "/section.properties", "r", encoding="utf-8") as fp:
			return javaproperties.load(fp)
	elif os.path.isfile(folder + "/content.adoc"):
		return load_asciidoc_attributes(folder + "/content.adoc")
	else:
		log_error("Error: Unable to load properties of '" + folder + "'")

# Returns attributes found in given AsciiDoc file
def load_asciidoc_attributes(adocFile):
	result = {}
	possibleAttributes = [ line for line in open(adocFile) if line.startswith(":")]
	for attr in possibleAttributes:
		m = re.search("^:(.*):(.*)$", attr)
		if m:
			result[m.group(1).strip()] = m.group(2).strip();
	if result["authors"]:
		result["author"] = result["authors"]

	return result

# Basename of given path
def path_leaf(path):
	head, tail = ntpath.split(path)
	return tail or ntpath.basename(head)

# run
if __name__ == "__main__":main()
