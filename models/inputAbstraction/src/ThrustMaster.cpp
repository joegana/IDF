#include "ThrustMaster.hh"

using namespace idf;

ThrustMaster::ThrustMaster(bool isMale) :
    ThrustMasterBase(isMale),
    topSwitch(0, 1),
    topButton(0, 1) {}