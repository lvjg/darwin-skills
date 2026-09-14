from decimal import Decimal, ROUND_HALF_UP
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

def price(value):
    return Decimal(value).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)

class PriceTest(unittest.TestCase):
    def test_rounding(self):
        with TemporaryDirectory() as directory:
            receipt = Path(directory) / 'receipt.txt'
            receipt.write_text(str(price('12.345')))
            self.assertEqual(receipt.read_text(), '12.35')

if __name__ == '__main__':
    unittest.main()
