#!/usr/bin/env python3

import sys, json, time, os.path

from urllib.request import Request, urlopen
from datetime import date


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

# http://www.byond.com/download/build/${BYOND_MAJOR}/${BYOND_MAJOR}.${BYOND_MINOR}_byond_linux.zip
if True:
	# Real getting
	print('Getting BYOND version from website...')
	try:
		req = Request('http://www.byond.com/download/version.txt', headers = {'User-Agent': 'Mozilla/5.0'})
		data_from_website = urlopen(req, timeout = 10).read().decode('utf-8').split('\n')
		print('Success!')
	except:
		print('Can not get latest version from BYOND website. Possiable reason: website or internet connection is down.')
		data_from_website = False
else:
	# Emulating for not "DOS-attacking" byond.com
	print('Getting BYOND version from website... (emulating)')
	data_from_website = '513.1542\n514.1557'.split('\n')
	time.sleep(2)


if data_from_website != False:

	versions_processed = []
	for str in data_from_website:
		versions_processed.append(str.split('.'))
	del str, data_from_website

	#print(json.dumps([1,2,3,{'4': 5, '6': 7}], separators=(',', ':')))

	BYOND_vers_online = {
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
		for x_values, y_values in zip(BYOND_vers_online.items(), data_from_cashe.items()):
			if x_values == y_values:
				print('Cashed version of BYOND is unchanged, passing.')
			else:
				print('Cashed version of BYOND is changed, updating.')
				with open('byond_ver_cashed.json', 'w') as fp:
					json.dump(BYOND_vers_online, fp, indent = 4)
	else:
		print('Website version of BYOND is only avaliable, cashing.')
		with open('byond_ver_cashed.json', 'w') as fp:
			json.dump(BYOND_vers_online, fp, indent = 4)

	print('BYOND versions:')
	print(json.dumps(BYOND_vers_online)) #, indent = 4))

elif data_from_website != False:
	print('Cashed version of BYOND is only avaliable.')
	print('BYOND versions:')
	print(json.dumps(data_from_cashe)) #, indent = 4))

else:
	print(' > FATAL ERROR! NO CASH FILE EXISTS AND NO CONNECTION ESTABLISHED TO WEBSITE. < ')
	sys.exit(1)

sys.exit(0)
