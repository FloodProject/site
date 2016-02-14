from pprint import pprint

from libcloud.compute.types import Provider
from libcloud.compute.providers import get_driver

cls = get_driver(Provider.RACKSPACE)
driver = cls('my username', 'my api key')

pprint(driver.list_sizes())
pprint(driver.list_nodes())