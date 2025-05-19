import '../Controllers/home_page_controller.dart';

enum ChannelTypes {
  general,
  private,
  specialNeeds,
  martyrsBefore2003,
  martyrsOfTerroristOperations,
  martyrsOfPopularMobilization,
  cooperationMechanismOfNajafGovernorate,
  politicalPrisoners, // Adding the new channel
}

extension ChannelTypesExtension on ChannelTypes {
  int get id {
    switch (this) {
      case ChannelTypes.general:
        return 1;
      case ChannelTypes.private:
        return 2;
      case ChannelTypes.specialNeeds:
        return 3;
      case ChannelTypes.martyrsBefore2003:
        return 4;
      case ChannelTypes.martyrsOfTerroristOperations:
        return 5;
      case ChannelTypes.martyrsOfPopularMobilization:
        return 6;
      case ChannelTypes.cooperationMechanismOfNajafGovernorate:
        return 19;
      case ChannelTypes.politicalPrisoners:
        return 20;
      default:
        return 0;
    }
  }

  String get name {
    switch (this) {
      case ChannelTypes.general:
        return 'عام';
      case ChannelTypes.private:
        return 'خاص';
      case ChannelTypes.specialNeeds:
        return 'ذوي الحتياجات الخاصة';
      case ChannelTypes.martyrsBefore2003:
        return 'شهداء قبل 2003';
      case ChannelTypes.martyrsOfTerroristOperations:
        return 'شهداء تعويض عمليات الارهابية';
      case ChannelTypes.martyrsOfPopularMobilization:
        return 'شهداء الحشد الشعبي';
      case ChannelTypes.cooperationMechanismOfNajafGovernorate:
        return 'الية تعاون محافضة النجف';
      case ChannelTypes.politicalPrisoners:
        return 'سجناء السياسين';
      default:
        throw "Unknown value";
    }
  }

  static ChannelTypes? fromId(int id) {
    switch (id) {
      case 1:
        return ChannelTypes.general;
      case 2:
        return ChannelTypes.private;
      case 3:
        return ChannelTypes.specialNeeds;
      case 4:
        return ChannelTypes.martyrsBefore2003;
      case 5:
        return ChannelTypes.martyrsOfTerroristOperations;
      case 6:
        return ChannelTypes.martyrsOfPopularMobilization;
      case 19:
        return ChannelTypes.cooperationMechanismOfNajafGovernorate;
      case 20:
        return ChannelTypes.politicalPrisoners;
      default:
        return null;
    }
  }
}

extension ChannelStateExtension on ChannelTypes {
  void setChannelState(HomePageController controller) {
    // Reset all variables to false before setting the state
    controller.haveMartyrsFoundation.value = false;
    controller.havePeopleWithSpecialNeeds.value = false;
    controller.havePoliticalPrisoners.value = false;
    controller.haveCooperationMechanismOfNajafGovernorate.value = false;

    // Set the appropriate variable to true based on the channelType
    switch (this) {
      case ChannelTypes.martyrsBefore2003:
      case ChannelTypes.martyrsOfTerroristOperations:
      case ChannelTypes.martyrsOfPopularMobilization:
        controller.haveMartyrsFoundation.value = true;
        break;
      case ChannelTypes.specialNeeds:
        controller.havePeopleWithSpecialNeeds.value = true;
        break;
      case ChannelTypes.politicalPrisoners:
        controller.havePoliticalPrisoners.value = true;
        break;
      case ChannelTypes.cooperationMechanismOfNajafGovernorate:
        controller.haveCooperationMechanismOfNajafGovernorate.value = true;
        break;
      default:
        break;
    }
  }
}
