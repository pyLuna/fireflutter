import { getDatabase } from "firebase-admin/database";
import { Config } from "../config";
import { User, UserCreateWithPhoneNumber } from "./user.interface";
import { getAuth } from "firebase-admin/auth";


/**
 * UserService
 */
export class UserService {
    /**
     * Get user data
     *
     * @param uid uid of the user
     * @returns the promise of the user data
     */
    static async get(uid: string): Promise<User> {
        const db = getDatabase();
        const data = (await db.ref(`${Config.users}/${uid}`).get()).val();
        return data as User;
    }

    /**
     * Create account with phone number
     *
     * @param params phone number
     * @returns the promise of the uid
     */
    static async createAccountWithPhoneNumber(params: UserCreateWithPhoneNumber): Promise<{
        code?: string,
        message?: string,
        uid?: string,
        customToken?: string,
        phoneNumber?: string
    }> {
        const auth = getAuth();
        try {
            const userRecord = await auth.createUser({ phoneNumber: params.phoneNumber });
            const customToken = await auth.createCustomToken(userRecord.uid);
            return { uid: userRecord.uid, customToken };
        } catch (e) {
            if (e instanceof Error) {
                if ((e as any).errorInfo.code) {
                    return { code: (e as any).errorInfo.code, message: (e as any).errorInfo.message, phoneNumber: params.phoneNumber };
                }
                return { code: e.name, message: e.message };
            } else {
                return { code: "unknown", message: "unknown error" };
            }
        }
    }


    /**
     * Deletes the user account from Firebase Auth
     * 
     * It only deletes the user account from Firebase Auth. Deletion of user data from Firestore or Realtime Database
     * must be done in clientend.
     * 
     * @param uid uid of the user
     */
    static async deleteAccount(uid: string): Promise<void> {

        // Delete user account
        const auth = getAuth();
        const db = getDatabase();
        try {
            await auth.deleteUser(uid);
            await db.ref(`${Config.commands}/${uid}`).update({
                deleteAccountResult: true,
            });
        } catch (e: any) {
            await db.ref(`${Config.commands}/${uid}`).update({
                deleteAccountResult: false,
                error: `${e.name}: ${e.message}`,
            });
        }

    }
}
