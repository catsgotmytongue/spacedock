
package com.funnyhatsoftware.spacedock.data;

import java.util.Comparator;

import android.annotation.SuppressLint;

public class Captain extends CaptainBase {
    static class CaptainComparator implements Comparator<Captain> {
        @Override
        public int compare(Captain o1, Captain o2) {
            int factionCompare = o1.getFaction().compareTo(o2.getFaction());
            if (factionCompare == 0) {
                int titleCompare = o1.getTitle().compareTo(o2.getTitle());
                if (titleCompare == 0) {
                    return DataUtils.compareInt(o2.getCost(), o1.getCost());
                }
                return titleCompare;
            }
            return factionCompare;
        }
    }

    public static Upgrade zeroCostCaptain(String faction) {
        for (Captain captain : Universe.getUniverse().captains.values()) {
            if (captain.getFaction().equals(faction) && captain.isZeroCost()) {
                return captain;
            }
        }
        throw new IllegalStateException("No zero cost captain exists for faction " + faction);
    }

    public Upgrade captainForId(String externalId) {
        return Universe.getUniverse().getCaptain(externalId);
    }

    public boolean isZeroCost() {
        return mCost == 0;
    }

    public int additionalTechSlots() {
        return (mSpecial.equals("addonetechslot") || mSpecial.equals("AddsHiddenTechSlot")) ? 1 : 0;
    }

    public int additionalCrewSlots() {
        return mSpecial.equals("AddTwoCrewSlotsDominionCostBonus") ? 2 : 0;
    }

    public boolean isKlingon() {
        return getFaction().equals("Klingon");
    }

    @SuppressLint("DefaultLocale")
    public String toString() {
        return String.format("%s-%d (%d)", getTitle(), getSkill(), getCost());
    }
}