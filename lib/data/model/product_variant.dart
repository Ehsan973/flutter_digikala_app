import 'package:digikala_app/data/model/variant.dart';
import 'package:digikala_app/data/model/variant_type.dart';

class ProductVariant {
  VariantType variantType;
  List<Variant> variantList;
  ProductVariant(this.variantType, this.variantList);
}
