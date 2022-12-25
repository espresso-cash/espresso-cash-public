// Autogenerated from Pigeon (v3.2.9), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.solana.solana_seed_vault;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class Api {

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class AccountDto {
    private @NonNull Long id;
    public @NonNull Long getId() { return id; }
    public void setId(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"id\" is null.");
      }
      this.id = setterArg;
    }

    private @NonNull String name;
    public @NonNull String getName() { return name; }
    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull String derivationPath;
    public @NonNull String getDerivationPath() { return derivationPath; }
    public void setDerivationPath(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"derivationPath\" is null.");
      }
      this.derivationPath = setterArg;
    }

    private @NonNull String publicKeyEncoded;
    public @NonNull String getPublicKeyEncoded() { return publicKeyEncoded; }
    public void setPublicKeyEncoded(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"publicKeyEncoded\" is null.");
      }
      this.publicKeyEncoded = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private AccountDto() {}
    public static final class Builder {
      private @Nullable Long id;
      public @NonNull Builder setId(@NonNull Long setterArg) {
        this.id = setterArg;
        return this;
      }
      private @Nullable String name;
      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }
      private @Nullable String derivationPath;
      public @NonNull Builder setDerivationPath(@NonNull String setterArg) {
        this.derivationPath = setterArg;
        return this;
      }
      private @Nullable String publicKeyEncoded;
      public @NonNull Builder setPublicKeyEncoded(@NonNull String setterArg) {
        this.publicKeyEncoded = setterArg;
        return this;
      }
      public @NonNull AccountDto build() {
        AccountDto pigeonReturn = new AccountDto();
        pigeonReturn.setId(id);
        pigeonReturn.setName(name);
        pigeonReturn.setDerivationPath(derivationPath);
        pigeonReturn.setPublicKeyEncoded(publicKeyEncoded);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("id", id);
      toMapResult.put("name", name);
      toMapResult.put("derivationPath", derivationPath);
      toMapResult.put("publicKeyEncoded", publicKeyEncoded);
      return toMapResult;
    }
    static @NonNull AccountDto fromMap(@NonNull Map<String, Object> map) {
      AccountDto pigeonResult = new AccountDto();
      Object id = map.get("id");
      pigeonResult.setId((id == null) ? null : ((id instanceof Integer) ? (Integer)id : (Long)id));
      Object name = map.get("name");
      pigeonResult.setName((String)name);
      Object derivationPath = map.get("derivationPath");
      pigeonResult.setDerivationPath((String)derivationPath);
      Object publicKeyEncoded = map.get("publicKeyEncoded");
      pigeonResult.setPublicKeyEncoded((String)publicKeyEncoded);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class SeedDto {
    private @NonNull Long authToken;
    public @NonNull Long getAuthToken() { return authToken; }
    public void setAuthToken(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"authToken\" is null.");
      }
      this.authToken = setterArg;
    }

    private @NonNull String name;
    public @NonNull String getName() { return name; }
    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull Long purpose;
    public @NonNull Long getPurpose() { return purpose; }
    public void setPurpose(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"purpose\" is null.");
      }
      this.purpose = setterArg;
    }

    private @NonNull List<AccountDto> accounts;
    public @NonNull List<AccountDto> getAccounts() { return accounts; }
    public void setAccounts(@NonNull List<AccountDto> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"accounts\" is null.");
      }
      this.accounts = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private SeedDto() {}
    public static final class Builder {
      private @Nullable Long authToken;
      public @NonNull Builder setAuthToken(@NonNull Long setterArg) {
        this.authToken = setterArg;
        return this;
      }
      private @Nullable String name;
      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }
      private @Nullable Long purpose;
      public @NonNull Builder setPurpose(@NonNull Long setterArg) {
        this.purpose = setterArg;
        return this;
      }
      private @Nullable List<AccountDto> accounts;
      public @NonNull Builder setAccounts(@NonNull List<AccountDto> setterArg) {
        this.accounts = setterArg;
        return this;
      }
      public @NonNull SeedDto build() {
        SeedDto pigeonReturn = new SeedDto();
        pigeonReturn.setAuthToken(authToken);
        pigeonReturn.setName(name);
        pigeonReturn.setPurpose(purpose);
        pigeonReturn.setAccounts(accounts);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("authToken", authToken);
      toMapResult.put("name", name);
      toMapResult.put("purpose", purpose);
      toMapResult.put("accounts", accounts);
      return toMapResult;
    }
    static @NonNull SeedDto fromMap(@NonNull Map<String, Object> map) {
      SeedDto pigeonResult = new SeedDto();
      Object authToken = map.get("authToken");
      pigeonResult.setAuthToken((authToken == null) ? null : ((authToken instanceof Integer) ? (Integer)authToken : (Long)authToken));
      Object name = map.get("name");
      pigeonResult.setName((String)name);
      Object purpose = map.get("purpose");
      pigeonResult.setPurpose((purpose == null) ? null : ((purpose instanceof Integer) ? (Integer)purpose : (Long)purpose));
      Object accounts = map.get("accounts");
      pigeonResult.setAccounts((List<AccountDto>)accounts);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static class ImplementationLimitsDto {
    private @NonNull Long maxBip32PathDepth;
    public @NonNull Long getMaxBip32PathDepth() { return maxBip32PathDepth; }
    public void setMaxBip32PathDepth(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"maxBip32PathDepth\" is null.");
      }
      this.maxBip32PathDepth = setterArg;
    }

    private @Nullable Long maxSigningRequests;
    public @Nullable Long getMaxSigningRequests() { return maxSigningRequests; }
    public void setMaxSigningRequests(@Nullable Long setterArg) {
      this.maxSigningRequests = setterArg;
    }

    private @Nullable Long maxRequestedSignatures;
    public @Nullable Long getMaxRequestedSignatures() { return maxRequestedSignatures; }
    public void setMaxRequestedSignatures(@Nullable Long setterArg) {
      this.maxRequestedSignatures = setterArg;
    }

    private @Nullable Long maxRequestedPublicKeys;
    public @Nullable Long getMaxRequestedPublicKeys() { return maxRequestedPublicKeys; }
    public void setMaxRequestedPublicKeys(@Nullable Long setterArg) {
      this.maxRequestedPublicKeys = setterArg;
    }

    private @Nullable Long authPurpose;
    public @Nullable Long getAuthPurpose() { return authPurpose; }
    public void setAuthPurpose(@Nullable Long setterArg) {
      this.authPurpose = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private ImplementationLimitsDto() {}
    public static final class Builder {
      private @Nullable Long maxBip32PathDepth;
      public @NonNull Builder setMaxBip32PathDepth(@NonNull Long setterArg) {
        this.maxBip32PathDepth = setterArg;
        return this;
      }
      private @Nullable Long maxSigningRequests;
      public @NonNull Builder setMaxSigningRequests(@Nullable Long setterArg) {
        this.maxSigningRequests = setterArg;
        return this;
      }
      private @Nullable Long maxRequestedSignatures;
      public @NonNull Builder setMaxRequestedSignatures(@Nullable Long setterArg) {
        this.maxRequestedSignatures = setterArg;
        return this;
      }
      private @Nullable Long maxRequestedPublicKeys;
      public @NonNull Builder setMaxRequestedPublicKeys(@Nullable Long setterArg) {
        this.maxRequestedPublicKeys = setterArg;
        return this;
      }
      private @Nullable Long authPurpose;
      public @NonNull Builder setAuthPurpose(@Nullable Long setterArg) {
        this.authPurpose = setterArg;
        return this;
      }
      public @NonNull ImplementationLimitsDto build() {
        ImplementationLimitsDto pigeonReturn = new ImplementationLimitsDto();
        pigeonReturn.setMaxBip32PathDepth(maxBip32PathDepth);
        pigeonReturn.setMaxSigningRequests(maxSigningRequests);
        pigeonReturn.setMaxRequestedSignatures(maxRequestedSignatures);
        pigeonReturn.setMaxRequestedPublicKeys(maxRequestedPublicKeys);
        pigeonReturn.setAuthPurpose(authPurpose);
        return pigeonReturn;
      }
    }
    @NonNull Map<String, Object> toMap() {
      Map<String, Object> toMapResult = new HashMap<>();
      toMapResult.put("maxBip32PathDepth", maxBip32PathDepth);
      toMapResult.put("maxSigningRequests", maxSigningRequests);
      toMapResult.put("maxRequestedSignatures", maxRequestedSignatures);
      toMapResult.put("maxRequestedPublicKeys", maxRequestedPublicKeys);
      toMapResult.put("authPurpose", authPurpose);
      return toMapResult;
    }
    static @NonNull ImplementationLimitsDto fromMap(@NonNull Map<String, Object> map) {
      ImplementationLimitsDto pigeonResult = new ImplementationLimitsDto();
      Object maxBip32PathDepth = map.get("maxBip32PathDepth");
      pigeonResult.setMaxBip32PathDepth((maxBip32PathDepth == null) ? null : ((maxBip32PathDepth instanceof Integer) ? (Integer)maxBip32PathDepth : (Long)maxBip32PathDepth));
      Object maxSigningRequests = map.get("maxSigningRequests");
      pigeonResult.setMaxSigningRequests((maxSigningRequests == null) ? null : ((maxSigningRequests instanceof Integer) ? (Integer)maxSigningRequests : (Long)maxSigningRequests));
      Object maxRequestedSignatures = map.get("maxRequestedSignatures");
      pigeonResult.setMaxRequestedSignatures((maxRequestedSignatures == null) ? null : ((maxRequestedSignatures instanceof Integer) ? (Integer)maxRequestedSignatures : (Long)maxRequestedSignatures));
      Object maxRequestedPublicKeys = map.get("maxRequestedPublicKeys");
      pigeonResult.setMaxRequestedPublicKeys((maxRequestedPublicKeys == null) ? null : ((maxRequestedPublicKeys instanceof Integer) ? (Integer)maxRequestedPublicKeys : (Long)maxRequestedPublicKeys));
      Object authPurpose = map.get("authPurpose");
      pigeonResult.setAuthPurpose((authPurpose == null) ? null : ((authPurpose instanceof Integer) ? (Integer)authPurpose : (Long)authPurpose));
      return pigeonResult;
    }
  }
  private static class ApiHostCodec extends StandardMessageCodec {
    public static final ApiHostCodec INSTANCE = new ApiHostCodec();
    private ApiHostCodec() {}
    @Override
    protected Object readValueOfType(byte type, ByteBuffer buffer) {
      switch (type) {
        case (byte)128:         
          return AccountDto.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)129:         
          return ImplementationLimitsDto.fromMap((Map<String, Object>) readValue(buffer));
        
        case (byte)130:         
          return SeedDto.fromMap((Map<String, Object>) readValue(buffer));
        
        default:        
          return super.readValueOfType(type, buffer);
        
      }
    }
    @Override
    protected void writeValue(ByteArrayOutputStream stream, Object value)     {
      if (value instanceof AccountDto) {
        stream.write(128);
        writeValue(stream, ((AccountDto) value).toMap());
      } else 
      if (value instanceof ImplementationLimitsDto) {
        stream.write(129);
        writeValue(stream, ((ImplementationLimitsDto) value).toMap());
      } else 
      if (value instanceof SeedDto) {
        stream.write(130);
        writeValue(stream, ((SeedDto) value).toMap());
      } else 
{
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter.*/
  public interface ApiHost {
    @NonNull ImplementationLimitsDto getImplementationLimitsForPurpose(@NonNull Long purpose);
    @NonNull Boolean hasUnauthorizedSeedsForPurpose(@NonNull Long purpose);
    @NonNull Boolean isAvailable(@NonNull Boolean allowSimulated);
    @NonNull List<SeedDto> getAuthorizedSeeds();
    @NonNull List<AccountDto> getAccounts(@NonNull Long authToken);
    @NonNull String getAccountByLevel(@NonNull Long bipLevel);

    /** The codec used by ApiHost. */
    static MessageCodec<Object> getCodec() {
      return ApiHostCodec.INSTANCE;
    }

    /** Sets up an instance of `ApiHost` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, ApiHost api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ApiHost.getImplementationLimitsForPurpose", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              Number purposeArg = (Number)args.get(0);
              if (purposeArg == null) {
                throw new NullPointerException("purposeArg unexpectedly null.");
              }
              ImplementationLimitsDto output = api.getImplementationLimitsForPurpose((purposeArg == null) ? null : purposeArg.longValue());
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ApiHost.hasUnauthorizedSeedsForPurpose", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              Number purposeArg = (Number)args.get(0);
              if (purposeArg == null) {
                throw new NullPointerException("purposeArg unexpectedly null.");
              }
              Boolean output = api.hasUnauthorizedSeedsForPurpose((purposeArg == null) ? null : purposeArg.longValue());
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ApiHost.isAvailable", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              Boolean allowSimulatedArg = (Boolean)args.get(0);
              if (allowSimulatedArg == null) {
                throw new NullPointerException("allowSimulatedArg unexpectedly null.");
              }
              Boolean output = api.isAvailable(allowSimulatedArg);
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ApiHost.getAuthorizedSeeds", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              List<SeedDto> output = api.getAuthorizedSeeds();
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ApiHost.getAccounts", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              Number authTokenArg = (Number)args.get(0);
              if (authTokenArg == null) {
                throw new NullPointerException("authTokenArg unexpectedly null.");
              }
              List<AccountDto> output = api.getAccounts((authTokenArg == null) ? null : authTokenArg.longValue());
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(binaryMessenger, "dev.flutter.pigeon.ApiHost.getAccountByLevel", getCodec());
        if (api != null) {
          channel.setMessageHandler((message, reply) -> {
            Map<String, Object> wrapped = new HashMap<>();
            try {
              ArrayList<Object> args = (ArrayList<Object>)message;
              Number bipLevelArg = (Number)args.get(0);
              if (bipLevelArg == null) {
                throw new NullPointerException("bipLevelArg unexpectedly null.");
              }
              String output = api.getAccountByLevel((bipLevelArg == null) ? null : bipLevelArg.longValue());
              wrapped.put("result", output);
            }
            catch (Error | RuntimeException exception) {
              wrapped.put("error", wrapError(exception));
            }
            reply.reply(wrapped);
          });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
  private static Map<String, Object> wrapError(Throwable exception) {
    Map<String, Object> errorMap = new HashMap<>();
    errorMap.put("message", exception.toString());
    errorMap.put("code", exception.getClass().getSimpleName());
    errorMap.put("details", "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorMap;
  }
}
