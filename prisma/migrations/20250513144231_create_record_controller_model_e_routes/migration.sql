/*
  Warnings:

  - You are about to drop the column `screenTime` on the `records` table. All the data in the column will be lost.
  - Added the required column `screenshot` to the `records` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_records" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" INTEGER NOT NULL,
    "score" INTEGER NOT NULL,
    "screenshot" TEXT NOT NULL,
    "gameId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "records_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "records_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "games" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_records" ("createdAt", "gameId", "id", "score", "updatedAt", "userId") SELECT "createdAt", "gameId", "id", "score", "updatedAt", "userId" FROM "records";
DROP TABLE "records";
ALTER TABLE "new_records" RENAME TO "records";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
