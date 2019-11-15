import '../utils/utils.dart';

class SupplierData{
  String supplier_guid;
  String supplier_id;
  String supplier_linkman;
  String supplier_mobilephone;
  String supplier_caption;
  String supplier_shorter;
  String supplier_province;
  String supplier_address;
  String supplier_zipcode;
  String supplier_telphone;
  String supplier_remark1;
  String supplier_remark2;
  String supplier_user_id;

  SupplierData(this.supplier_guid, this.supplier_id,this.supplier_linkman,
      this.supplier_mobilephone, this.supplier_caption,this.supplier_shorter,
      this.supplier_province, this.supplier_address,this.supplier_zipcode,
      this.supplier_telphone, this.supplier_remark1,this.supplier_remark2,this.supplier_user_id
      );

  SupplierData.fromJson(Map<String, dynamic> json)
      :
        supplier_guid= json['guid'],
        supplier_id= json['id'] == null ? '/':json['id'],
        supplier_linkman= json['linkman'] == null ? '/':json['linkmane'],
        supplier_mobilephone= json['mobilephone'] == null ? '/':json['mobilephone'],
        supplier_caption= json['caption'] == null ? '/':json['caption'],
        supplier_shorter= json['shorter'] == null ? '/':json['shorter'],
        supplier_province= json['province'] == null ? '/':json['province'],
        supplier_address= json['address'] == null ? '/':json['address'],
        supplier_zipcode= json['zipcode'] == null ? '/':json['zipcode'],
        supplier_telphone= json['telphone'] == null ? '/':json['telphone'],
        supplier_remark1= json['remark1'] == null ? '/':json['remark1'],
        supplier_remark2= json['remark2'] == null ? '/':json['remark2'],
        supplier_user_id= json['user_id'] == null ? '/':json['user_id'];

  Map<String, dynamic> toJson() =>
      {
        'guid': supplier_guid,
        'id': supplier_id,
        'linkman': supplier_linkman,
        'mobilephone': supplier_mobilephone,
        'caption': supplier_caption,
        'shorter': supplier_shorter,
        'province': supplier_province,
        'address': supplier_address,
        'zipcode': supplier_zipcode,
        'telphone': supplier_telphone,
        'remark1': supplier_remark1,
        'remark2': supplier_remark2,
        'user_id': supplier_user_id,
      };

}