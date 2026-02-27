import 'package:dependencies/dependencies.dart';

class CredentialShareInvitation extends Equatable {
  const CredentialShareInvitation({
    required this.type,
    required this.id,
    required this.from,
    required this.body,
    required this.attachments,
    required this.createdTime,
  });

  factory CredentialShareInvitation.fromJson(Map<String, dynamic> json) {
    return CredentialShareInvitation(
      type: json['type'] as String,
      id: json['id'] as String,
      from: json['from'] as String,
      body: InvitationBody.fromJson(json['body'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List)
          .map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdTime: json['created_time'] as String,
    );
  }

  final String type;
  final String id;
  final String from;
  final InvitationBody body;
  final List<Attachment> attachments;
  final String createdTime;

  @override
  List<Object?> get props => [type, id, from, body, attachments, createdTime];
}

class InvitationBody extends Equatable {
  const InvitationBody({
    required this.goalCode,
    required this.goal,
    required this.accept,
  });

  factory InvitationBody.fromJson(Map<String, dynamic> json) {
    return InvitationBody(
      goalCode: json['goal_code'] as String,
      goal: json['goal'] as String,
      accept: (json['accept'] as List).cast<String>(),
    );
  }

  final String goalCode;
  final String goal;
  final List<String> accept;

  @override
  List<Object?> get props => [goalCode, goal, accept];
}

class Attachment extends Equatable {
  const Attachment({
    required this.id,
    required this.mediaType,
    required this.format,
    required this.data,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] as String,
      mediaType: json['media_type'] as String,
      format: json['format'] as String,
      data: AttachmentData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  final String id;
  final String mediaType;
  final String format;
  final AttachmentData data;

  @override
  List<Object?> get props => [id, mediaType, format, data];
}

class AttachmentData extends Equatable {
  const AttachmentData({required this.json});

  factory AttachmentData.fromJson(Map<String, dynamic> json) {
    return AttachmentData(
      json: PresentationRequest.fromJson(json['json'] as Map<String, dynamic>),
    );
  }

  final PresentationRequest json;

  @override
  List<Object?> get props => [json];
}

class PresentationRequest extends Equatable {
  const PresentationRequest({
    required this.options,
    required this.presentationDefinition,
  });

  factory PresentationRequest.fromJson(Map<String, dynamic> json) {
    return PresentationRequest(
      options: PresentationOptions.fromJson(
        json['options'] as Map<String, dynamic>,
      ),
      presentationDefinition: PresentationDefinition.fromJson(
        json['presentation_definition'] as Map<String, dynamic>,
      ),
    );
  }

  final PresentationOptions options;
  final PresentationDefinition presentationDefinition;

  @override
  List<Object?> get props => [options, presentationDefinition];
}

class PresentationOptions extends Equatable {
  const PresentationOptions({required this.challenge, required this.domain});

  factory PresentationOptions.fromJson(Map<String, dynamic> json) {
    return PresentationOptions(
      challenge: json['challenge'] as String,
      domain: json['domain'] as String,
    );
  }

  final String challenge;
  final String domain;

  @override
  List<Object?> get props => [challenge, domain];
}

class PresentationDefinition extends Equatable {
  const PresentationDefinition({
    required this.id,
    required this.name,
    required this.purpose,
    required this.inputDescriptors,
  });

  factory PresentationDefinition.fromJson(Map<String, dynamic> json) {
    return PresentationDefinition(
      id: json['id'] as String,
      name: json['name'] as String,
      purpose: json['purpose'] as String,
      inputDescriptors: (json['input_descriptors'] as List)
          .map((e) => InputDescriptor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String id;
  final String name;
  final String purpose;
  final List<InputDescriptor> inputDescriptors;

  @override
  List<Object?> get props => [id, name, purpose, inputDescriptors];
}

class InputDescriptor extends Equatable {
  const InputDescriptor({
    required this.id,
    required this.name,
    required this.purpose,
    required this.constraints,
  });

  factory InputDescriptor.fromJson(Map<String, dynamic> json) {
    return InputDescriptor(
      id: json['id'] as String,
      name: json['name'] as String,
      purpose: json['purpose'] as String,
      constraints: Constraints.fromJson(
        json['constraints'] as Map<String, dynamic>,
      ),
    );
  }

  final String id;
  final String name;
  final String purpose;
  final Constraints constraints;

  @override
  List<Object?> get props => [id, name, purpose, constraints];
}

class Constraints extends Equatable {
  const Constraints({required this.limitDisclosure, required this.fields});

  factory Constraints.fromJson(Map<String, dynamic> json) {
    return Constraints(
      limitDisclosure: json['limit_disclosure'] as String,
      fields: (json['fields'] as List)
          .map((e) => FieldConstraint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String limitDisclosure;
  final List<FieldConstraint> fields;

  @override
  List<Object?> get props => [limitDisclosure, fields];
}

class FieldConstraint extends Equatable {
  const FieldConstraint({required this.path, this.filter, this.purpose});

  factory FieldConstraint.fromJson(Map<String, dynamic> json) {
    return FieldConstraint(
      path: (json['path'] as List).cast<String>(),
      filter: json['filter'] as Map<String, dynamic>?,
      purpose: json['purpose'] as String?,
    );
  }

  final List<String> path;
  final Map<String, dynamic>? filter;
  final String? purpose;

  @override
  List<Object?> get props => [path, filter, purpose];
}
