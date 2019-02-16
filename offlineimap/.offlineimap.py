import os
import subprocess


def passwd(account):
    account = os.path.basename(account)
    username = os.environ['USER']
    path = '{}/.passwd/{}.gpg'.format(os.path.expanduser('~'), account)
    args = ['gpg', '--use-agent', '--quiet', '--batch', '--decrypt', path]

    try:
        return subprocess.check_output(args).strip()

    except subprocess.CalledProcessError:
        return ''
