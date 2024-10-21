class Comentario {
final int? postId;
final int? id;
final String? name;
final String? email;
final String? body;
const Comentario({this.postId , this.id , this.name , this.email , this.body });
Comentario copyWith({int? postId, int? id, String? name, String? email, String? body}){
return Comentario(
          postId:postId ?? this.postId,
          id:id ?? this.id,
          name:name ?? this.name,
          email:email ?? this.email,
          body:body ?? this.body
        );
        }
        
Map<String,Object?> toJson(){
    return {
          'postId': postId,
          'id': id,
          'name': name,
          'email': email,
          'body': body
    };
}

static Comentario fromJson(Map<String , Object?> json){
    return Comentario(
            postId:json['postId'] == null ? null : json['postId'] as int,
            id:json['id'] == null ? null : json['id'] as int,
            name:json['name'] == null ? null : json['name'] as String,
            email:json['email'] == null ? null : json['email'] as String,
            body:json['body'] == null ? null : json['body'] as String
    );
}

@override
String toString(){
    return '''Comentario(
              postId:$postId,
              id:$id,
              name:$name,
              email:$email,
              body:$body
    ) ''';
}

@override
bool operator ==(Object other){
    return other is Comentario && 
        other.runtimeType == runtimeType &&
        other.postId == postId && 
        other.id == id && 
        other.name == name && 
        other.email == email && 
        other.body == body;
}
      
@override
int get hashCode {
    return Object.hash(
          runtimeType,
          postId, 
          id, 
          name, 
          email, 
          body
    );
}
    
}
      
      
  
     