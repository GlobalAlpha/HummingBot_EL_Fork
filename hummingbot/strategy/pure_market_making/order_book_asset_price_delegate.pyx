from .asset_price_delegate cimport AssetPriceDelegate
from hummingbot.market.market_base import MarketBase
from decimal import Decimal
from hummingbot.core.utils.exchange_rate_conversion import ExchangeRateConversion

cdef class OrderBookAssetPriceDelegate(AssetPriceDelegate):
    def __init__(self, market: MarketBase, trading_pair: str, base_asset: str, quote_asset: str):
        super().__init__()
        self._market = market
        self._trading_pair = trading_pair
        self._base_asset = base_asset
        self._quote_asset = quote_asset

    cdef object c_get_mid_price(self):
        ex_rate_conversion = ExchangeRateConversion.get_instance()
        mid_price = (self._market.c_get_price(self._trading_pair, True) + self._market.c_get_price(self._trading_pair, False))/Decimal('2')
        print("mid_price")
        print(mid_price)
        return ex_rate_conversion.convert_token_value_with_override(1, self._base_asset, self._quote_asset) * mid_price

    @property
    def ready(self) -> bool:
        return (self._market.ready & ExchangeRateConversion.get_instance().ready)
