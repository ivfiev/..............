import subprocess

try:
  status = subprocess.check_output(['mullvad', 'status'], text=True)

  words = status.split()

  prompt = 'Disconnected from VPN!'
  if words[0] == 'Connected':
    prompt = f'{words[0]} - {words[2]}, {' '.join(words[-2:])}'

  relays = subprocess.check_output(['mullvad', 'relay', 'list'], text=True)

  lines = relays.split('\n')
  country, city, code = '', '', ''
  wofi = ''

  for line in lines:
    if not line:
      country, city, code = '', '', ''
      continue
    if not line.startswith('\t'):
      country = line.split(' (')[0].strip()
    elif line.startswith('\t\t'):
      if '-wg-' in line:
        code = line.split()[0].strip()
        wofi += f'{country}, {city}, {code}\n'
    elif line.startswith('\t'):
      city = line.split(' (')[0].strip()

  choice = subprocess.check_output(
    ['wofi', '--show', 'dmenu', '--prompt', prompt, '-i', '-M', 'fuzzy'],
    input=wofi,
    text=True)
  hostname = choice.split()[-1]

  if 'Disconnected' in prompt:
    subprocess.check_output(['mullvad', 'connect'], text=True)

  subprocess.check_output(['mullvad', 'relay', 'set', 'location', hostname], text=True)
except Exception as e:
  subprocess.check_output(['logger', '-t', __file__, str(e)])
