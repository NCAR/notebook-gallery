import re
import socket


def identify_host():
    """Function to determine which host the client is running from.
    """
    cheyenne = re.compile(r'cheyenne')
    casper = re.compile(r'casper')
    hobart = re.compile(r'h([a-zA-Z0-9]+).cgd.ucar.edu')

    hostname = socket.getfqdn()

    is_on_cheyenne = cheyenne.search(hostname)
    is_on_casper = casper.search(hostname)
    is_on_hobart = hobart.search(hostname)

    try:
        if is_on_cheyenne:
            return 'cheyenne'

        elif is_on_casper:
            return 'casper'

        elif is_on_hobart:
            return 'hobart'

        else:
            return 'unknown'

    except Exception as exc:
        raise exc('Unable to determine which NCAR machine you are running on...')
