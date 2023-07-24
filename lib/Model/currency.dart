class Currency {
  final String name;
  final double price;
  final double usd_market_cap;
  final double usd_24h_vol;
  final double usd_24h_change;
  final int last_updated_at;

  Currency(
    this.price,
    this.usd_market_cap,
    this.usd_24h_vol,
    this.usd_24h_change,
    this.last_updated_at,
    this.name,
  );
}
