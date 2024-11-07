enum ProductType
{
  simple,
  variable,
}

String checkProductType(ProductType type)
{
  switch(type)
  {
    case ProductType.simple:
      return 'simple';
    case ProductType.variable:
      return 'variable';
  }
}