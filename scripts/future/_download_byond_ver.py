#!/usr/bin/env python3

import sys, json, time, os, platform
from urllib.request import Request, urlopen, urlretrieve, build_opener, install_opener
#from datetime import date


os.system('cls' if os.name=='nt' else 'clear')

script_os = platform.system()
script_os_supported = ['Linux', 'Windows']


print('Script started (OS: ' + script_os + ')')

if not script_os in script_os_supported:
	print(' > FATAL ERROR! THIS OS IS SUPPORTED (supported: ' + str(script_os_supported) + '). < ')
	sys.exit(1)

opener = build_opener()
opener.addheaders = [('User-agent', 'Mozilla/5.0')]
install_opener(opener)


print('Getting BYOND version from cashe...')

if os.path.isfile('byond_ver_cashed.json'):
	f = open('byond_ver_cashed.json', 'r')
	data_from_cashe = json.load(f)
	#print(data_from_cashe)
	print('Success!')

	# for i in data_from_cashe:
	# 	print(' 1. ' + i + ': ')
	# 	for ii in data_from_cashe.get(i):
	# 		print('  2. ' + ii + ': ')
	# 		for iii in data_from_cashe[ii]:
	# 			print('   3. ' + iii)

	f.close()
else:
	print('There is no cashe.')
	data_from_cashe = False

if True:
	# Real getting
	print('Getting BYOND version from website...')
	try:
		req = Request('http://www.byond.com/download/version.txt') #, headers = {'User-Agent': 'Mozilla/5.0'})
		data_from_website_raw = urlopen(req, timeout = 10).read().decode('utf-8').split('\n')
		print('Success!')
	except:
		print('Can not get latest version from BYOND website. Possiable reason: website or internet connection is down.')
		data_from_website_raw = False
else:
	# Emulating for not "DOS-attacking" byond.com
	print('Getting BYOND version from website... (emulating)')
	data_from_website_raw = '513.1542\n514.1557'.split('\n')
	time.sleep(2)


if data_from_website_raw != False:

	versions_processed = []
	for str in data_from_website_raw:
		versions_processed.append(str.split('.'))
	del str, data_from_website_raw

	#print(json.dumps([1,2,3,{'4': 5, '6': 7}], separators=(',', ':')))

	data_from_website = {
		'BYOND versions': {
			'Stable': {
				'Major': int(versions_processed[0][0]),
				'Minor': int(versions_processed[0][1])
			},
			'Beta': {
				'Major': int(versions_processed[1][0]),
				'Minor': int(versions_processed[1][1])
			}, #'updated': { 'date': str(date.today()) }
		}
	}
	del versions_processed

	if data_from_cashe != False:
		for x_values, y_values in zip(data_from_website.items(), data_from_cashe.items()):
			if x_values == y_values:
				print('Cashed version of BYOND is unchanged, passing.')
				BYOND_vers = data_from_cashe
			else:
				print('Cashed version of BYOND is changed, updating.')
				with open('byond_ver_cashed.json', 'w') as fp:
					json.dump(data_from_website, fp, indent = 4)
				BYOND_vers = data_from_website
	else:
		print('Website version of BYOND is only avaliable, cashing.')
		with open('byond_ver_cashed.json', 'w') as fp:
			json.dump(data_from_website, fp, indent = 4)
		BYOND_vers = data_from_website

elif data_from_website_raw != False:
	print('Cashed version of BYOND is only avaliable.')
	BYOND_vers = data_from_cashe

else:
	print(' > FATAL ERROR! NO CASH FILE EXISTS AND NO CONNECTION ESTABLISHED TO WEBSITE. < ')
	sys.exit(1)


print('BYOND versions:')
print(json.dumps(BYOND_vers)) #, indent = 4))

print('Getting BYOND itself from website...')

target_file = '%s.%s_byond_linux.zip' % (BYOND_vers["BYOND versions"]["Stable"]["Major"], BYOND_vers["BYOND versions"]["Stable"]["Minor"])

print('Downloading: "' + target_file +'"')

try:
	# http://www.byond.com/download/build/${MAJOR_VERSION}/${VERSION}_byond_linux.zip
	# http://www.byond.com/download/build/${BYOND_MAJOR}/${BYOND_MAJOR}.${BYOND_MINOR}_byond_linux.zip
	# http://www.byond.com/download/build/LATEST/${BYOND_MAJOR}.${BYOND_MINOR}_byond_linux.zip
	urlretrieve(
		'http://www.byond.com/download/build/LATEST/',
		target_file
	)
	print('Success!')
except:
	print('Can not get latest version from BYOND website. Possiable reason: website or internet connection is down.')
	print(' > FATAL ERROR! NO CONNECTION ESTABLISHED TO WEBSITE, CANN\'NT DOWNLOAD BYOND LAUNCHER. < ')
	sys.exit(1)

sys.exit(0)
